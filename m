From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Mon, 30 Mar 2015 18:09:10 +0200
Message-ID: <20150330160910.GZ4441@8bytes.org>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
	<20150325140410.GS4441@8bytes.org>
	<CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
	<20150326120547.GU4441@8bytes.org>
	<CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi AceLan,

On Fri, Mar 27, 2015 at 08:48:22AM +0800, AceLan Kao wrote:
> Very thanks for your time.
> This is the log booting with kernel 4.0rc5 without fglrx loaded.

Thanks, it scheds some light on the issue. See below.

> [    0.080177] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b8 info 0000
> [    0.080181] AMD-Vi:        mmio-addr: 00000000feb80000
> [    0.080198] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
> [    0.080200] AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
> [    0.081192] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 05:00.0 flags: 00 devid_to: 00:14.4
> [    0.081194] AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
> [    0.081204] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
> [    0.081207] AMD-Vi:   DEV_SPECIAL(IOAPIC[4])		devid: 00:14.0
> [    0.081208] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:00.0

This is dump of the IVRS table contents. It tells us that IOAPIC with ID
5 uses PCI request-id 00:00.0. But this information is wrong, it uses
request-id 00:00.1, as seen below:

> [   23.515063] AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:00.1 address=0x000000fdf80c0020 flags=0x0a00]

This message comes from an interrupt request sent by the IOAPIC, and it
uses a different request-id. Can you try to update the BIOS on that
machine and test if it fixes the issue?


	Joerg
