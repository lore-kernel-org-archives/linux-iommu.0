From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Linux Plumbers ACPI/PM, PCI Microconference
Date: Tue, 30 Jul 2013 18:36:32 -0600
Message-ID: <1375230992.31262.87.camel@ul30vt.home>
References: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
	<CAKocOOOgEb5h1dZWP_2UqBKhSK9U-kxKUbvTdzHfds=RiDzNJg@mail.gmail.com>
	<1476124.sWE2ygoo2D@vostro.rjw.lan>
	<B8EFE96D1287C24090BAD9D858E15E6174F0B5@sisaex01sj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <B8EFE96D1287C24090BAD9D858E15E6174F0B5@sisaex01sj>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Myron Stowe <myron.stowe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2013-07-31 at 00:02 +0000, Shuah Khan wrote:
> On 07/30/2013 05:38 PM, Rafael J. Wysocki wrote:
> > On Wednesday, July 17, 2013 08:31:55 AM Shuah Khan wrote:
> >> Myron,
> >>
> >> On Tue, Jul 16, 2013 at 8:21 PM, Myron Stowe <myron.stowe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>
> >>>
> >>> Shuah - You brought up the idea about "Converting drivers from Legacy
> >>> PM ops to dev_pm_ops"; would you like to present what you have
> >>> done/encountered so far?
> >>>
> >>
> >> Awesome. Yes, I would like to present what I have done so far and I do
> >> have a couple of things that could benefit from a face to face
> >> discussion which would help me make progress on the rest of the work
> >> that needs to get done.
> >
> > Care to sumbit a formal proposal through the LPC web page?
> >
> > Rafael
> >
> >
> 
> Rafael,
> 
> I did submit a formal talk proposal to LinuxCon/LPC and it was rejected. 
> Submission is closed now as far as I know.

Microconference topics should be submitted here:

http://www.linuxplumbersconf.org/2013/ocw/events/LPC2013/proposals/new
