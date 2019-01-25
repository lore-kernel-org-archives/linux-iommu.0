From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: iproc: Add feature to set order mode
Date: Fri, 25 Jan 2019 09:05:31 -0600
Message-ID: <20190125150531.GI14636@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
 <1547785403-32268-2-git-send-email-srinath.mannam@broadcom.com>
 <20190118150713.GB25249@google.com>
 <CABe79T741K-jPpkgCWWOoFRGY2Nf3zs1ea=NO=sLke=WJUT9iA@mail.gmail.com>
 <20190124193131.GG14636@google.com>
 <CABe79T5Qu-j6j0sGn7PD-z+QidLMNc0U03g6RB1YgoXpaQ8=WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABe79T5Qu-j6j0sGn7PD-z+QidLMNc0U03g6RB1YgoXpaQ8=WA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arun Ananthapadmanaban <arun.ananthapadmanaban@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 25, 2019 at 03:13:38PM +0530, Srinath Mannam wrote:
> On Fri, Jan 25, 2019 at 1:01 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jan 24, 2019 at 02:10:18PM +0530, Srinath Mannam wrote:
> > > On Fri, Jan 18, 2019 at 8:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jan 18, 2019 at 09:53:21AM +0530, Srinath Mannam wrote:
> > > > > Order mode in RX header of incoming pcie packets can be override to
> > > > > strict or loose order based on requirement.
> > > > > Sysfs entry is provided to set dynamic and default order modes of upstream
> > > > > traffic.
> > > > ...
> > > > Are you talking about the Relaxed Ordering bit in the TLP Attributes
> > > > field?  If so, please use the exact language used in the spec and
> > > > include a reference, e.g., to PCIe r4.0, sec 2.2.6.4, 2.4, etc.
> > > >
> > > Yes Relax ordering bit in TLP. I will use spec reference. Thanks.
> > > > I'm hesitant about a new sysfs file for this.  That automatically
> > > > creates a user-space dependency on this iProc feature.  Who would use
> > > > this file?
> > > >
> > > This is the specific feature given in iProc, used to improve
> > > performance for the endpoints which does not support
> > > ordering configuration at its end.
> > > This is the reason we used sysfs file, which allows user to change
> > > ordering based on endpoint used and requirement.
> > > we are using these sysfs files to configure ordering to improve
> > > performance in NVMe endpoints with SPDK/DPDK drivers.
> > > If we enable this default in kernel, then it is applicable to all
> > > endpoints connected. But it may not required for all endpoints.
> >
> > Normally, relaxed ordering is used only when an endpoint sets the
> > "Relaxed Ordering" attribute bit in a TLP.  The endpoint is only
> > allowed to do that if relaxed ordering is enabled in the Device
> > Control register.
> Yes, endpoint has to set RO attribute in up-streaming TLPs.
> But in most of NVMe SSDs even Relax ordering bit in device controller
> register is set,
> still it send TLPs with RO attribute disable (strict order).
> >
> > If I understand correctly, this sysfs knob would let you configure the
> > iProc RC so it handles *all* TLPs (or just those in certain address
> > ranges) with relaxed ordering, regardless of whether the endpoint has
> > relaxed ordering, or even whether it supports relaxed ordering at all.
> Yes, iProc can enable/disable RO attribute in given address range regardless of
> endpoint settings.
> >
> > My gut feeling is that this is a messy hack, and if you want the
> > performance benefits of relaxed ordering, you should just choose an
> > NVMe endpoint that supports it correctly.
>
> Most of the NVMe endpoints available in market are sending TLPs in
> strict order even Relax ordering bit in device controller register
> is set.  This is the reason to add this dynamic ordering feature in
> iProc IP.

I'm not very sympathetic to this argument about NVMe endpoints not
supporting Relaxed Ordering.  Relaxed Ordering has been in the PCIe
spec since the very beginning in 2002 (see PCIe r1.0, sec 2.4.3).  Why
should we jump through hoops to tack this on after the fact if the
endpoint designer couldn't be bothered?

This sysfs knob is problematic because it's not safe and it can't
be supported across architectures.

It's not safe because only the endpoint and its driver know the
ordering requirements.  We *hope* the user only enables relaxed
ordering when it is safe.  Even when it's not safe, it makes things
faster and works most of the time, so it's pretty tempting.  But
eventually it will lead to data corruption.

We try to avoid sysfs things that are architecture-specific.  This
particular file would only exist on iProc, and then any user-space
software that uses it would only work on iProc.

Bjorn
