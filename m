From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
	6e4bf5867783)
Date: Fri, 6 Apr 2018 06:35:55 +0200
Message-ID: <20180406043555.GA7632@light.dominikbrodowski.net>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
	<20180406011418.GE12349@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180406011418.GE12349-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.lendacky-5C7GfCeVMHo@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 06, 2018 at 02:14:18AM +0100, Mark Brown wrote:
> On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
> > Christoph,
> > 
> > unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
> > dmesg diff between fec777c385b6 and 6e4bf5867783:
> 
> Adding Vinod and Pierre from Intel in case they have any ideas here.
> Which model of XPS13 is this (2015?)?

Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016, with

# CONFIG_GPIOLIB is not set,

just CONFIG_PINCTRL=y but no

# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set

(yes, this works, see commit d1fa74520dcd ), and,

CONFIG_SND_HDA_I915=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=y
CONFIG_SND_SST_IPC_ACPI=y
CONFIG_SND_SOC_INTEL_SST_ACPI=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=y
CONFIG_SND_SOC_INTEL_HASWELL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
CONFIG_SND_SOC_I2C_AND_SPI=y
CONFIG_SND_SOC_AC97_CODEC=y


Thanks for looking into this!

	Dominik


> > -sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> > -haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
> > -haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
> > -haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
> > -broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
> > -broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
> > -input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15
> > +broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered
> 
> > So it seems that sst-acpi is unhappy with this patch. Any ideas?
