From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr()
	for ->flush_queue
Date: Thu, 21 Sep 2017 17:10:40 +0200
Message-ID: <20170921151040.szekdgibvojrdzhf@linutronix.de>
References: <20170906103459.oi2nn7jondjqdo5m@linutronix.de>
	<CABp9dQUcXTAX9ggX+TAMHE2oH0SF8bcu47E=UYG9fgJdKBXEVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABp9dQUcXTAX9ggX+TAMHE2oH0SF8bcu47E=UYG9fgJdKBXEVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vinod Adhikary <vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2017-09-11 22:22:11 [-0400], Vinod Adhikary wrote:
> Dear all,
Hi,

> Thank you for the great community support and support from Sebastian to
> provide me this patch. I wanted to send this email to inform you and
> perhaps get some information on how I could keep myself updated on updates
> in regards to linux-rt. I apologize if I'm spamming you with this email.

There is a rt-users mailing list, see
	https://wiki.linuxfoundation.org/realtime/communication/mailinglists

> I noticed `Bug: Scheduling while atomic` on ahci after building 4.9 rt and
> reported the issue on oftc channel. Sebastian quickly helped me get a patch
> and my `journalctl -f` was clean without any such messages. Yesterday I
> decided to build 4.11 without the patch but I saw a whole bunch of similar
> bug logs not just on ahci but on my nic card as well among a few others.
> There were a few instances where I had to hard shutdown my machine. I
> patched 4.11 with Sebastian's patch again and so far it's been okay for
> about 24 hours and going.

It sounds like the same issue. I taking this for v4.11 RT and v4.9 will
pick it at some point.

> My concern is, how I can provide more information to resolve this issue,
> perhaps in the next release. Please let me know how I can be of help.

usually providing a backtrace like you did to the rt-usrs list is
enough.

> Thank you

Sebastian
