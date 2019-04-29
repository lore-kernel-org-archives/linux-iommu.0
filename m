From: "StarostaCZ-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <starostacz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on AMD
	boards.
Date: Mon, 29 Apr 2019 12:51:20 +0200
Message-ID: <26c4a175-dae2-3410-6924-92fe7c8ec6fe@gmail.com>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190429094847.GI26546@localhost>
Content-Language: cs
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,
sorry for other questions, but I am new in this list:
Is Ubuntu server 19.04 with "kernel 5.0.9-050009-generic" good for this 
test?
Can I add attachments to this lists?
And who is xhci and iommu maintainers? Are they CC in this mail?

starosta

Dne 29.4.2019 v 11:48 Johan Hovold napsal(a):
> So this is a debian 4.18 kernel seemingly crashing due to a xhci or
> iommu issue.
>
> Can you reproduce this on a mainline kernel?
>
> If so, please post the corresponding logs to the lists and CC the xhci
> and iommu maintainers (added to CC).
