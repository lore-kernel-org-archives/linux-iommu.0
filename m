From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Fri, 8 Jan 2016 22:52:59 +0800
Message-ID: <568FCD4B.4000807@iommu.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
	<1451988444-4694-6-git-send-email-vincent.wan@amd.com>
	<20160107120422.GB19149@8bytes.org>
	<CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
	<20160108121855.GU18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160108121855.GU18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


>>
>>
>> static bool check_device(struct device *dev)
>> {
>>          u16 devid;
>> ......
>>
>>          /* No PCI device */
>>          if (!dev_is_pci(dev) && (get_acpihid_device_id(dev, NULL) < 0))
>>                  return false;
>>
>>          devid = get_device_id(dev);
>
> That is true for this case, but the other call-sites of get_device_id()
> still have to care about a potential negative return value, right?
>

Actually I am supposing the '.add_device' will be the first called in 
iommu initializing stage, so I think as long as having no error of check 
device here, any call-sites of get_device_id() will be fine, because 
adding device successfully should be the pre-condition of any iommu 
function can be performed, please correct me.

static int amd_iommu_add_device(struct device *dev)
{
	struct iommu_dev_data *dev_data;
	struct iommu_domain *domain;
	struct amd_iommu *iommu;
	u16 devid;
	int ret;

	if (!check_device(dev) || get_dev_data(dev))
		return 0;

	devid = get_device_id(dev);
	iommu = amd_iommu_rlookup_table[devid];


Vincent.
>
> 	Joerg
>
>
