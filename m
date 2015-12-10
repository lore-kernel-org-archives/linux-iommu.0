From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Map scatterlists more parsimoniously
Date: Thu, 10 Dec 2015 20:49:37 +0800
Message-ID: <CAGS+omBWFgpQQKV2=qL9G6qPbW_EL2bSjkLPq6KwQGAdHEDSHw@mail.gmail.com>
References: <104b4682056bc5b4aa0afadd39196c03fc06555d.1447249098.git.robin.murphy@arm.com>
	<1447307229.27650.5.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447307229.27650.5.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Tiffany Lin <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 12, 2015 at 1:47 PM, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> On Wed, 2015-11-11 at 14:54 +0000, Robin Murphy wrote:
>> Whilst blindly assuming the worst case for segment boundaries and
>> aligning every segment individually is safe from the point of view
>> of respecting the device's parameters, it is also undeniably a waste
>> of IOVA space. Futhermore, the knock-on effects of more pages than

"Furthermore" (checkpatch actually caught this, not me ;-) )

>> necessary being exposed to device access, additional overhead in page
>> table updates and TLB invalidations, etc., are even more undesirable.
>>
>> Improve matters by taking the actual boundary mask into account to
>> actively detect the cases in which we really do need to adjust a
>> segment, and avoid wasting space in the remainder.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> Hi all,
>>
>> I've given this some brief testing on Juno with USB and (via magic
>> PCI hacks) SATA to confirm that all the +1s and -1s at least seem to
>> be in the right places, so I'm throwing it out now for a head-start on
>> checking whether it also helps the media folks with the v4l portability
>> issues they're up against (I'm confident it should). If all goes well I
>> figure I'll repost next week based on rc1 instead of some random local
>> development commit.
>>
>> Robin.
>
> It works well on MT8173. containing
> VDA/VEA(VideoDecodeAccelerator/VideoEncodeAccelerator) unit test.
>
> Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
