From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
	interface
Date: Wed, 08 Feb 2017 15:09:33 +0100
Message-ID: <5fef7241-bb87-54ed-2516-d3207334274d@samsung.com>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
	<CGME20170206161330epcas3p185c7719afc89ab2ad87e55e9f62ccfa1@epcas3p1.samsung.com>
	<1486397429-29327-10-git-send-email-joro@8bytes.org>
	<3e4709a7-2231-7c76-18bd-6e2d6b802b8e@samsung.com>
	<20170208135742.GE7339@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20170208135742.GE7339-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 2017-02-08 14:57, Joerg Roedel wrote:
> On Tue, Feb 07, 2017 at 01:36:15PM +0100, Marek Szyprowski wrote:
>>> +	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
>>> +				     "sysmmu.%pa", &ioaddr);
>> Can we stick to the common name across the /sysfs and use
>> dev_name(data->sysmmu)
>> or even dev_name(dev) here?
>>
>> ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
>> dev_name(dev));
> That means that we have multiple 'struct device' with the same name,
> no? I think will lead to confusion when using dev_printk, as its not
> clear anymore which device is refered to in the message.

Each sysmmu device has unique name, like every other platform device
instantiated from device tree. Here is an example from the OdroidXU3
(Exynos5422 based):

# ls -1 /sys/bus/platform/devices/ | grep sysmmu
10a60000.sysmmu
10a70000.sysmmu
11200000.sysmmu
11210000.sysmmu
11d40000.sysmmu
11f10000.sysmmu
11f20000.sysmmu
12880000.sysmmu
12890000.sysmmu
128a0000.sysmmu
128c0000.sysmmu
128d0000.sysmmu
128e0000.sysmmu
13e80000.sysmmu
13e90000.sysmmu
14640000.sysmmu
14650000.sysmmu
14680000.sysmmu

IMHO there is no need for open coding new unique names if device name,
which already contains the base address, can be used instead.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
