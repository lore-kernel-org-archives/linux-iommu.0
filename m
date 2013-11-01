From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: VT-d and x2apic: broken resume after suspend to ram
Date: Fri, 1 Nov 2013 17:02:06 +0100
Message-ID: <20131101160206.GM17455@8bytes.org>
References: <CA+MoWDqoBxuFhBsf_rVBT1C8=mwj02hXgPfuWnjY4yeVa-84cA@mail.gmail.com>
	<20131101130702.GA3348@8bytes.org>
	<CA+MoWDoDTFarOLUHgNmUFksRvV-R+7jufUwLbsS8ecaO+_m2kQ@mail.gmail.com>
	<20131101142115.GK17455@8bytes.org>
	<CA+MoWDq4jYCD9zGaPA_Z4AL3Rj6hu4-rMEofn=8uWEGP6Tdruw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+MoWDq4jYCD9zGaPA_Z4AL3Rj6hu4-rMEofn=8uWEGP6Tdruw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Senna Tschudin <peter.senna-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Seiji Aguchi <seiji.aguchi-7rDLJAbr9SE@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 01, 2013 at 04:47:47PM +0100, Peter Senna Tschudin wrote:
> Only serial ports over USB:
> usb 2-1.3.2: pl2303 converter now attached to ttyUSB0
> 
> The issue with no_console_suspend is that the monitor is powered off
> on suspend and never resume after that. The external monitor enters in
> power save mode during suspend and also never resume. Do you know if
> replacing my wifi/bt card by this:
> 
> http://www.startech.com/Cards-Adapters/Serial-Cards-Adapters/2-Port-RS232-Mini-PCI-Express-Serial-Card-16950-UART~MPEX2S952
> 
> would enable to use the serial console for seeing kernel debug messages?

Who knows, depends on the BIOS in your machine, I guess. But I would say
there is a at least a better chance with this than with a USB-Serial
adapter.


	Joerg
