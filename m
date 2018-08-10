From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Date: Fri, 10 Aug 2018 09:54:05 -0700
Message-ID: <20180810165405.GA82669@otc-nc-03>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
 <20180809134417.50de7fe7@t450s.home>
 <20180809230311.GA79703@otc-nc-03>
 <20180810174836.66d9791b@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810174836.66d9791b@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Gage Eads <gage.eads@intel.com>, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 10, 2018 at 05:48:36PM +0100, Alan Cox wrote:
> > The hardware isn't public yet, so can't talk about it :-(. Once this patch gets 
> > merged, will let the OSV engagement folks drive it for inclusions. We 
> > could mark this for stable, but i would rather wait until we know the 
> > timeline when they are expecting it to be in. It shouldn't break anything
> > since we are just enforcing the spec.
> 
> Until a new better spec appears...

Well, here we are talking about PIN interrupts and VF's. IMO it would be
weird to allow Virtual functions and physical interrupts other than MSIx.

There are other things in the PCIe spec which could be enforced in SW
or expect devices to implement them.  

What might be ok is probably doing the right thing in SW as done in this
patch, additionaly maybe we can flag them and say "Your device is busted"
message. 

> 
> I know there is always fun when it comes to the people involved in
> such a screwup having to admit it in public but this should IMHO be
> tied to a PCI identifier table so that we know what the afflicted
> hardware is. Otherwise some day in the future SRIOV will grow new features
> and we'll have no idea what particular devices we need to narrow the
> workaround too and indeed not necessarily even know this device is the
> only one, as we'll silently fix other stuff then have it break on us
> later.
> 
> Alan
