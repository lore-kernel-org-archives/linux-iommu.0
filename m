From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: VT-d and x2apic: broken resume after suspend to ram
Date: Fri, 1 Nov 2013 15:21:15 +0100
Message-ID: <20131101142115.GK17455@8bytes.org>
References: <CA+MoWDqoBxuFhBsf_rVBT1C8=mwj02hXgPfuWnjY4yeVa-84cA@mail.gmail.com>
	<20131101130702.GA3348@8bytes.org>
	<CA+MoWDoDTFarOLUHgNmUFksRvV-R+7jufUwLbsS8ecaO+_m2kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+MoWDoDTFarOLUHgNmUFksRvV-R+7jufUwLbsS8ecaO+_m2kQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, Nov 01, 2013 at 02:21:07PM +0100, Peter Senna Tschudin wrote:
> On Fri, Nov 1, 2013 at 2:07 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > Which kernels have you tried? Does it happen with all of them or is
> > there a kernel-version where this started?
> 
> I'm using 3.11.6-200.fc19.x86_64. I always had VT-d enabled, and
> suspend / resume never worked on Linux. I did not know that disabling
> VT-d could be a workaround to the resume issue until yesterday.
> 
> Does this have anything in common to:
> https://bugzilla.redhat.com/show_bug.cgi?id=752613

This is probably not related. As far as I can see this issue was about
boot problem with discrete graphics while your problem is related to
suspend/resume.

The next thing I would try on your machine is to get some kernel debug
messages from resume. This might be hard to get, since your notebook
has probably no serial port. But you can try to boot with
no_console_suspend on the kernel cmdline and see if it gives you any
output on resume.

Maybe some of the VT-d guys can take a look too?


	Joerg
