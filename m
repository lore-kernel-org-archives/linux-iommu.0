From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Kernel hangs when intel_iommu=on on 4.2.0
Date: Tue, 5 Apr 2016 15:42:11 -0600
Message-ID: <20160405154211.2bae8558@t450s.home>
References: <CAEDtQEzqdjeG4y5HpW-TNStoCwfmmiGqVzQvWmzbpLrVYLW2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAEDtQEzqdjeG4y5HpW-TNStoCwfmmiGqVzQvWmzbpLrVYLW2Uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom Wimmenhove <tom.wimmenhove-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 5 Apr 2016 14:39:10 -0400
Tom Wimmenhove <tom.wimmenhove-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I am running kernel 4.2.0 on ubuntu 15.10. I have Vt-d enabled in my
> BIOS with the latest BIOS version (on a DX58SO board, with a Xeon
> W3520).
> 
> When I boot with "intel_iommu=on", first the kernel spits out some DMA
> remapping messages, sits there for about 10 seconds and then spits a
> trace and hangs (no sysrq). On previous kernels (specifically 3.16.0)
> I did not have these issues when booting, but sometimes get DMAR
> related errors in syslog when using PCI GPU passthrough in a qemu
> guest, causing garbage on the screen of the guest.

It would probably be really useful to know what those DMA remapping
messages where rather than guess.  Can you capture them?  A photo if
not a serial console would be better than nothing.  I notice there's a
Marvell SATA controller installed, those are always suspect due to
their DMA aliasing issue.  Thanks,

Alex
