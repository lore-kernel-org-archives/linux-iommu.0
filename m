From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Thu, 31 Aug 2017 11:23:39 +0100
Message-ID: <8822281c-1188-1135-2cd3-68f988761cd8@nvidia.com>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-2-git-send-email-joro@8bytes.org>
 <f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
 <20170830120902.kqtxh2ls4ob7xpwy@8bytes.org>
 <c6ee1ce0-7193-be63-c84d-73795c727d26@nvidia.com>
 <20170830153034.GK19533@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830153034.GK19533-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 30/08/17 16:30, Joerg Roedel wrote:
> Hi Jon,
> 
> On Wed, Aug 30, 2017 at 03:22:05PM +0100, Jon Hunter wrote:
>> Yes I can confirm that this fixes the crash. I assume that you will fix
>> the error path for bus_set_iommu() above as I believe now it needs to
>> call iommu_device_sysfs_remove().
> 
> Thanks for testing the patch. I updated the error-path and put the
> commit below into the iommu-tree:
Today's -next is still failing and I don't see this fix in your public
tree yet [0]. Can you push this out?

Cheers
Jon

[0] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/

-- 
nvpublic
