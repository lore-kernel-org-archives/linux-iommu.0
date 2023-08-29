Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30226AAC
	for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 22:56:17 +0000 (UTC)
Received: from skinsburskii. (unknown [167.220.2.160])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD1912129BE5;
	Tue, 29 Aug 2023 15:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD1912129BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1693349770;
	bh=nyvYnGsEyShboBzxmQn3PSwN8FW7roJbS77GrA4ZnHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M094I3z0+sDFf4NH62cv9xn0kA5fiOZFW8oUlyz8r+Z721lbaCUwd6HhhyHTrvA5s
	 74CNBSZyibMMbt2f0M/P++HQ4RUeYGESvLP60lfK11iQwuLdyVuw60xgDTT6zQaL8F
	 g8+YRjosvfws530u3xpW1Xpn2RhLtPGkFNrnCkAk=
Date: Tue, 29 Aug 2023 15:07:40 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.de>
Cc: "Gowans, James" <jgowans@amazon.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"stanislav.kinsburskii@gmail.com" <stanislav.kinsburskii@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, iommu@lists.linux.dev,
	kvm <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Message-ID: <20230829220740.GA26605@skinsburskii.>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
 <20230823024500.GA25462@skinsburskii.>
 <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>

On Mon, Aug 28, 2023 at 10:50:19PM +0200, Alexander Graf wrote:
> +kexec, iommu, kvm
> 
> On 23.08.23 04:45, Stanislav Kinsburskii wrote:
> > 
> > +akpm, +linux-mm
> > 
> > On Fri, Aug 25, 2023 at 01:32:40PM +0000, Gowans, James wrote:
> > > On Fri, 2023-08-25 at 10:05 +0200, Greg Kroah-Hartman wrote:
> > > 
> > > Thanks for adding me to this thread Greg!
> > > 
> > > > On Tue, Aug 22, 2023 at 11:34:34AM -0700, Stanislav Kinsburskii wrote:
> > > > > This patch addresses the need for a memory allocator dedicated to
> > > > > persistent memory within the kernel. This allocator will preserve
> > > > > kernel-specific states like DMA passthrough device states, IOMMU state, and
> > > > > more across kexec.
> > > > > The proposed solution offers a foundational implementation for potential
> > > > > custom solutions that might follow. Though the implementation is
> > > > > intentionally kept concise and straightforward to foster discussion and
> > > > > feedback, it's fully functional in its current state.
> > > Hi Stanislav, it looks like we're working on similar things. I'm looking
> > > to develop a mechanism to support hypervisor live update for when KVM is
> > > running VMs with PCI device passthrough. VMs with device passthrough
> > > also necessitates passing and re-hydrating IOMMU state so that DMA can
> > > continue during live update.
> > > 
> > > Planning on having an LPC session on this topic:
> > > https://lpc.events/event/17/abstracts/1629/ (currently it's only a
> > > submitted abstract so not sure if visible, hopefully it will be soon).
> > > 
> > > We are looking at implementing persistence across kexec via an in-memory
> > > filesystem on top of reserved memory. This would have files for anything
> > > that needs to be persisted. That includes files for IOMMU pgtables, for
> > > guest memory or userspace-accessible memory.
> > > 
> > > It may be nice to solve all kexec persistence requirements with one
> > > solution, but we can consider IOMMU separately. There are at least three
> > > ways that this can be done:
> > > a) carving out reserved memory for pgtables. This is done by your
> > > proposal here, as well as my suggestion of a filesystem.
> > > b) pre/post kexec hooks for drivers to serialise state and pass it
> > > across in a structured format from old to new kernel.
> > > c) Reconstructing IOMMU state in the new kernel by starting at the
> > > hardware registers and walking the page tables. No state passing needed.
> > > 
> > > Have you considered option (b) and (c) here? One of the implications of
> > > (b) and (c) are that they would need to hook into the buddy allocator
> > > really early to be able to carve out the reconstructed page tables
> > > before the allocator is used. Similar to how pkram [0] hooks in early to
> > > carve out pages used for its filesystem.
> > > 
> > Hi James,
> > 
> > We are indeed working on similar things, so thanks for chiming in.
> > I've seen pkram proposal as well as your comments there.
> > 
> > I think (b) will need some persistent-over-kexec memory to pass the
> > state across kexec as well as some key-value store persisted as well.
> > And the proposed persistent memory pool is aimed exactly for this
> > purpose.
> > Or do you imply some other way to pass driver's data accross kexec?
> 
> 
> If I had to build this, I'd probably do it just like device tree passing on
> ARM. It's a single, physically contiguous blob of data whose entry point you
> pass to the target kernel. IIRC ACPI passing works similarly. This would
> just be one more opaque data structure that then needs very strict
> versioning and forward/backward compat guarantees.
> 

Device tree or ACPI are options indeed. However AFAIU in case of DT user
space has to involved into the picture to modify and complie it, while
ACPI isn't flexible or easily extendable.
Also, AFAIU both these standards were designed with passing
hardware-specific data in mind from bootstrap software to an OS kernel
and thus were never really intended to be used for creating a persistent
state accross kexec.
To me, an attempt to use either of them to pass kernel-specific data looks
like an abuse (or misuse) excused by the simplicity of implementation.

> 
> > I dind't consider (c) yet, thanks for for the pointer.
> > 
> > I have a question in this scope: how is PCI devices registers state is persisted
> > across kexec with the files system you are working on? I.e. how does
> > driver know, that the device shouldn't not be reinitialized?
> 
> 
> The easiest way to do it initially would be kernel command line options that
> hack up the drivers. But I suppose depending on the option we go with, you
> can also use the respective "natural" path:
> 
> (a) A special metadata file that explains the state to the driver
> (b) An entry in the structured file format that explains the state to the
> target driver
> (c) Compatible target drivers try to enumerate state from the target
> device's register file
> 

Command line option is the simplest way to go indeed, but from my POV
it's good only for pointing to a particualr object, which is persisted
somehow else. But it we have a persistence mechanism, then I think we
can make another step forward and don't use command line at all (which
is a bit cumbersome and errorprone due to it's human-readable and
serialized nature).

I'm leaning towards some kind of "natural" path you mentioned... I guess
I'm a bit confused with the word "file" here, as it sounds line it
implies a file system driver, and I'm not sure that's what we want for
driver specific data.

> 
> > 
> > > > > Potential applications include:
> > > > > 
> > > > >    1. Allowing various in-kernel entities to allocate persistent pages from
> > > > >       a singular memory pool, eliminating the need for multiple region
> > > > >       reservations.
> > > > > 
> > > > >    2. For in-kernel components that require the allocation address to be
> > > > >       available on kernel kexec, this address can be exposed to user space and
> > > > >       then passed via the command line.
> > > Do you have specific examples of other state that needs to be passed
> > > across? Trying to see whether tailoring specifically to the IOMMU case
> > > is okay. Conceptually IOMMU state can be reconstructed starting with
> > > hardware registers, not needing reserved memory. Other use-cases may not
> > > have this option.
> > > 
> > Well, basically it's IOMMU state and PCI devices to skip/avoid
> > initializing.
> > I bet there can be other misc (and unrelated things) like persistent
> > filesystems, block devices, etc. But I don't have a solid set of use
> > cases to present.
> 
> 
> Would be great if you could think through the problem space until LPC so we
> can have a solid conversation there :)
> 

Yeah, I have a few ideas I'll try to implement and share before LPC.
Unfortunatelly I'm not planning to attend it this year, so this
conversation will be without me.
But I'll do my best to provide as much content to discuss as I can.

> 
> > 
> > > > As you have no in-kernel users of this, it's not something we can even
> > > > consider at the moment for obvious reasons (neither would you want us
> > > > to.)
> > > > 
> > > > Can you make this part of a patch series that actually adds a user,
> > > > probably more than one, so that we can see if any of this even makes
> > > > sense?
> > > I'm very keen to see this as well. The way that the IOMMU drivers are
> > > enlightened to hook into your memory pool will likely be similar to how
> > > they would hook into my proposal of an in-memory filesystem.
> > > Do you have code available showing the IOMMU integration?
> > > 
> > No, I don't have such a code yet.
> > But I was thinking that using such a allocator in the mempool allows
> > to hide this implementation under the hood of an existent generic
> > mechanism, which is then can be used to create persistent objects (file
> > system, for example) on top of it.
> 
> 
> Unfortunately it's practically impossible to have a solid conversation on
> generic mechanisms without actual users to see how they fit in with the real
> world. That's Greg's answer to your patch set and I tend to agree. What if
> (b) or (c) turn out much more viable? Then we've wasted a lot of effort in
> shaping up the allocator for no good reason.
> 

This is fair.
I sent such a small piece, because I wanted to get some opinions about
the approach in general without too much investement into.
Thanks to you and Greg, I now have the feadeback I was looking for, so
I'm planning to come up with a series including in-kernel users, like
Greg suggested.

Thanks,
Stanislav

