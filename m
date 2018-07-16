From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Borken IOMMU+i915
Date: Mon, 16 Jul 2018 09:21:21 +0800
Message-ID: <5B4BF311.5020500@linux.intel.com>
References: <84fu0kaomw.wl-Peter.Chubb@data61.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <84fu0kaomw.wl-Peter.Chubb-RgbkMxAV74wUb6iz2VnApA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter.Chubb-RgbkMxAV74wUb6iz2VnApA@public.gmane.org, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Peter,

There is already a patch to revert that broken patch.

https://patchwork.kernel.org/patch/10513017/

Best regards,
Lu Baolu

On 07/15/2018 04:29 PM, Peter.Chubb-RgbkMxAV74wUb6iz2VnApA@public.gmane.org wrote:
> Hi Lu,
> 	In recent kernels, i915 graphics with intel_iommu=on has been
> 	giving me a blank screen.
>
> 	git bisect points at your patch ab96746aaa34
> 	"iommu/vt-d: Clean up pasid quirk for pre-production devices"
>
> 	Either one of the pre-production devices made it into my Dell
> 	laptop, or there's something else wrong with the patch.
>
> 	Reverting that patch gives me text console and X11 graphics;
> 	keeping it in yields a blank screen on boot.
>
> 	My laptop is a Dell  Inc. Precision 7710/0PMJX2, BIOS 1.15.4 12/08/2017
> 	CPU is  Intel(R) Core(TM) i7-6920HQ CPU @ 2.90GHz
> 	(family: 0x6, model: 0x5e, stepping: 0x3)
>
> Peter C
