From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Date: Tue, 25 Sep 2018 15:58:41 +0100
Message-ID: <130edd60-d92a-9871-334b-943fe8acffee@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526072055-86990-14-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

Just two minor things below, that I noticed while using fault handlers
for SVA. From my perspective the series is fine otherwise

On 11/05/2018 21:54, Jacob Pan wrote:
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +=A0=A0=A0=A0=A0=A0 struct iommu_param *param =3D dev->iommu_param;
> +=A0=A0=A0=A0=A0=A0 int ret =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0 if (!param)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> +
> +=A0=A0=A0=A0=A0=A0 mutex_lock(&param->lock);

Could we check that param->fault_param isn't NULL here, so that the
driver can call this function unconditionally in a cleanup path?

> +=A0=A0=A0=A0=A0=A0 /* we cannot unregister handler if there are pending =
faults */
> +=A0=A0=A0=A0=A0=A0 if (!list_empty(&param->fault_param->faults)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unlock;
> +=A0=A0=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0=A0=A0 kfree(param->fault_param);
> +=A0=A0=A0=A0=A0=A0 param->fault_param =3D NULL;
> +=A0=A0=A0=A0=A0=A0 put_device(dev);
> +unlock:
> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&param->lock);
> +
> +=A0=A0=A0=A0=A0=A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +
> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU model specific drivers when fault is detected, typica=
lly
> + * in a threaded IRQ handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct
> iommu_fault_event *evt)
> +{
> +=A0=A0=A0=A0=A0=A0 int ret =3D 0;
> +=A0=A0=A0=A0=A0=A0 struct iommu_fault_event *evt_pending;
> +=A0=A0=A0=A0=A0=A0 struct iommu_fault_param *fparam;
> +
> +=A0=A0=A0=A0=A0=A0 /* iommu_param is allocated when device is added to g=
roup */
> +=A0=A0=A0=A0=A0=A0 if (!dev->iommu_param | !evt)

Should probably be ||

Thanks,
Jean
