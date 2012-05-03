From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Thu, 03 May 2012 12:58:39 -0600
Message-ID: <4FA2D55F.2090708@wwwdotorg.org>
References: <1334588670-15124-1-git-send-email-thierry.reding@avionic-design.de>
	<4FA2CE32.7010406@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FA2CE32.7010406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/03/2012 12:28 PM, Stephen Warren wrote:
> On 04/16/2012 09:04 AM, Thierry Reding wrote:
>> This commit adds the device node required to probe NVIDIA Tegra 20 GART
>> hardware from the device tree.
> 
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> 
>> +	gart: gart@7000f000 {
>> +		compatible = "nvidia,tegra20-gart";
>> +		reg = < 0x7000f000 0x00000100    /* controller registers */
>> +		        0x58000000 0x02000000 >; /* GART aperture */
>> +	};
...
> As such, I think this node should be more like:
> 
> mc: mc@7000f000 {
>     compatible = "nvidia,tegra20-mc";
>     reg = <0x7000f000 0x00000100>;
> };
> 
> Then, one of following options can be taken:
[to represent the fact that MC and GART are essentially the same HW module]
...

Yet another option is to explicitly use the MFD subsystem for this; I
guess options 1 and 3 that I gave were essentially open-coding MFD anyway.

Offline, Hiroshi mentioned that he had looked at MFD, and ended up
thinking it was a rather heavy-weight solution in this case though.
