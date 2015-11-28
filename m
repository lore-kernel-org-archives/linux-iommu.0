From: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH V5 RESEND 0/3] Add iommu support for hi6220 HiKey board
Date: Sat, 28 Nov 2015 10:09:07 +0800
Message-ID: <56590CC3.5050401@hisilicon.com>
References: <1447986309-47548-1-git-send-email-puck.chen@hisilicon.com>
	<20151127114920.GH24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151127114920.GH24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, puck.chen-Dw/NWeUnuQfQT0dZR+AlfA@public.gmane.org, arnd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2015/11/27 19:49, Joerg Roedel wrote:
> On Fri, Nov 20, 2015 at 10:25:06AM +0800, Chen Feng wrote:
>> eg:
>> struct iommu_domain *domain = iommu_domain_alloc(bus);
>> iommu_attach_device(domain, dev);
>> struct iova_domain *iovad = (struct iova_domain *)m_dev->archdata.iommu;
>> struct iova * t_iova = alloc_iova(iovad, size, limit_pfn, align);
>> iommu_map(domain, t_iova->pfn_lo << 12, phy_addr, size, port);
> 
> Any reason the media subsystem should use the iommu-api directly, and
> not the dma-api? You can make your iommu available by adapting the
> common dma-iommu implementation from Robin Murphy to your iommu to make
> it usable through the dma-api.
> 

ok, I will change this to dma-api. Since v1 version, the dma-api was not ok for arm64.
I will do this with dma-api function.
> 
> 	Joerg
> 
> 
> .
> 
