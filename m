From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Using dma-ranges with iommu to limit range of iova
Date: Mon, 5 Mar 2018 12:16:25 +0000
Message-ID: <561a5d76-eddf-bf07-4eda-295fbbdc1e3e@arm.com>
References: <b2f9355e-7a59-0017-1d84-897e4c8735f2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b2f9355e-7a59-0017-1d84-897e4c8735f2-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On 05/03/18 09:06, Vivek Gautam wrote:
> Hi all,
> 
> I have a question regarding usage of 'dma-ranges', can someone point me 
> in the right direction?
> On qcom soc, few of the master devices with iommu attached to them, have 
> limitations in using the iova address range. They can allow the iova to 
> be only in a certain range, e.g. video codec firmware can only access 
> iova only in a first few MBs as the video's arm core reset starts at 0x0.
> To do that, I earlier, had the understanding that we can modify the 
> iommu_domain's geometry aperture. But that looks kind of a hacky way to 
> get the domain for the device and modify the aperture.
> I was trying to explore if we can use the dma-ranges property. But the 
> iommu bindings documentation doesn't really talks much about usage of 
> dma-ranges.
> Can someone help me with with the answer to - can we use 'dma-ranges' to 
> limit a device's iova address access? If yes, then how?

Yes, if the device has physical restrictions on what it can address, 
then "dma-ranges" is the correct way to describe that. That should be 
pretty much orthogonal to the IOMMU binding and combine in the obvious 
way, e.g.:

	...
	soc {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "simple-bus";
		ranges;

		...

		iommu@f0000000 {
			compatible = "iommu";
			reg = <0xf0000000 0x1000>;
			#iommu-cells = <0>;
		};

		...

		subsystem {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "simple-bus";
			ranges;
			/* Devices can only drive address bits 0:23 */
			dma-ranges = <0 0 0x1000000>;

			device {
				iommus = <&iommu>;
			};
		};
	};
	...

In terms of Linux, for the straightforward platform device case 
of_dma_configure() initialises the subsystem devices' DMA masks based on 
the size covered by "dma-ranges", and the DMA API code respects the 
device's DMA mask when allocating IOVAs. The only problem is the bit in 
the middle where the device driver's dma_set_mask() call can just trash 
of_dma_configure()'s initial mask, because there's no way to 
differentiate an explicitly-specified mask from a default one. It's also 
even uglier for PCI devices since the existing "pass the host bridge's 
node as the device's" bodge happens to work for the "dma-coherent" 
property but is a bit broken in general and doesn't work at all for 
"dma-ranges".

Fixing all of this (not to mention the DT/ACPI interaction aspect) has 
been hovering around #3 on my to-do list for the past couple of years 
now, but things keep sneaking in above it :(

Robin.
