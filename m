From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
 6e4bf5867783)
Date: Thu, 5 Apr 2018 22:56:57 +0200
Message-ID: <20180405205657.GA1788@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: thomas.lendacky@amd.com, tglx@linutronix.de, dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us, konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org, peterz@infradead.org, iommu@lists.linux-foundation.org, mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: iommu@lists.linux-foundation.org

Christoph,

unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
dmesg diff between fec777c385b6 and 6e4bf5867783:

-sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
-haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
-haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
-haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
-broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> System Pin mapping ok
-broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload0 Pin mapping ok
-broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Offload1 Pin mapping ok
-broadwell-audio broadwell-audio: snd-soc-dummy-dai <-> Loopback Pin mapping ok
-broadwell-audio broadwell-audio: rt286-aif1 <-> snd-soc-dummy-dai mapping ok
-input: broadwell-rt286 Headset as /devices/pci0000:00/INT3438:00/broadwell-audio/sound/card1/input15
+broadwell-audio broadwell-audio: ASoC: CPU DAI System Pin not registered

So it seems that sst-acpi is unhappy with this patch. Any ideas?

Thanks,
	Dominik
