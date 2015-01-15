From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
Date: Thu, 15 Jan 2015 18:35:03 +0000
Message-ID: <54B80857.7060407@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
	<1421136128.27675.58.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421136128.27675.58.camel@mtksdaap41>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13/01/15 08:02, Yingjoe Chen wrote:
> On Mon, 2015-01-12 at 20:48 +0000, Robin Murphy wrote:
>> Hi all,
>>
>> Whilst it's a long way off perfect, this has reached the point of being
>> functional and stable enough to be useful, so here it is. The core
>> consists of the meat of the arch/arm implementation modified to remove
>> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
>> allocator instead of the bitmap-based one. For that, this series depends
>> on my "Genericise the IOVA allocator" series posted earlier[1].
>
> Hi Robin,
>
> We'd to give it a try. Do you have a public git tree contains both
> series?
>
> Joe.C

Now that the server seems to be properly accessible again, I've made a 
branch with both series available here:

   git://linux-arm.org/linux-rm iommu/dma

Note that in the current state it also depends on having the ARM SMMU 
driver selected in the config, due to an oversight on my part :(

Robin.
