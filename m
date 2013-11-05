From: "Alexander E. Patrakov" <patrakov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Gigabyte H87N-WIFI, MSI Z87I boards need intel_iommu=igfx_off
Date: Tue, 5 Nov 2013 22:24:48 +0600
Message-ID: <CAN_LGv3Rb9XJ1G8Z7M31avsToUkPQvV9iAKGR1XpOmYvjwS0EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello.

I bought a Gigabyte H87N-WIFI Mini-ITX motherboard for use in a
mediacenter PC. And stumbled onto a bug: HDMI audio does not work at
all, with i/o errors from aplay and "playback write error (DMA or IRQ
trouble?)" in dmesg. I opened a bug about that:
https://bugzilla.kernel.org/show_bug.cgi?id=60769

As Intel engineers persuaded me that the bug is not reproducible on
their hardware, I decided to buy a different Mini-ITX motherboard to
get rid of it: MSI Z87I. Result: wasted money, because it suffers from
the same bug and the shop does not accept returns.

Later I found a set of kernel options that successfully work around
the bug on both boards:

intel_iommu=igfx_off snd_hda_intel.align_buffer_size=1

Please add a quirk to the kernel so that the intel_iommu=igfx_off
option automatically applies to both boards. The common thing that
they have is a 8086:0c0c audio device.

Some information about the hardware is available in the bug report in
the form of alsa-info.sh output. If you need anything else, please
ask.

Please note that I cannot swap these motherboards endlessly, because
the fanless cooling system in the PC already shows signs of wear in
the adhesive pads that need to be attached to the bottom of the
motherboard. So I'd like to wait a day or so until your replies,
collect information from the currently-running MSI board, then swap to
Gigabyte, collect data again and never change boards again.

-- 
Alexander E. Patrakov
