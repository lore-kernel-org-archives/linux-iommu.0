From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: VFIO and scheduled SR-IOV cards
Date: Wed, 10 Jul 2013 13:23:55 +0300
Message-ID: <20130710102355.GB10203@redhat.com>
References: <20130603163305.GC4094@irqsave.net>
	<1370282529.30975.344.camel@ul30vt.home>
	<51ACE1B5.2050102@redhat.com>
	<1370285865.30975.361.camel@ul30vt.home>
	<20130604155030.GA5991@irqsave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130604155030.GA5991-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 04, 2013 at 05:50:30PM +0200, Beno=EEt Canet wrote:
> =

> Hello,
> =

> More informations on how the hardware works.
> =

> -Each VF will have its own memory and MMR, etc.
> That means the resources are not shared.
> =

> -Each VF will have its own bus number, function number and device number.
> That means request ID is separated for each VF.
> =

> There is also VF save/restore area for the switch.
> =

> A VF regular memory (not MMR) is still accessible after a switch out.
> =

> But when a function VF1 is scheduled a read to a MRR of VF number 0 could=
 return
> the value of the same MMR in VF number 1 because VF number 1 is switched =
on and
> the PF processor is busy servicing VF number 1.
> =

> This could confuse the guest VF driver so the unmap and block or a same g=
oal
> achieving technique is required.
> =

> I hope these informations makes the area of the problem to solve narrower.
> =

> Best regards
> =

> Beno=EEt Canet

Confused.
You have one VF accessing BAR of another VF?
Why?

-- =

MST
