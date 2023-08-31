Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E48F57
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:26:37 +0000 (UTC)
Received: from skinsburskii. (unknown [167.220.2.160])
	by linux.microsoft.com (Postfix) with ESMTPSA id 576FD212A787;
	Thu, 31 Aug 2023 10:26:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 576FD212A787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1693502790;
	bh=nfTPUyS74OZsYR901USpAVlQVSz9pTNKt+fbqvjENVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9RJ2AkxTRu5KW6j3vuPuIkv8RGXzQueX0k4tMowfXafF6KiTLt+HqRDsZfJO8iNR
	 w3tVH/MsHxBW3JMnBMO6EPVN/0rAft0KVqSEGIYrvdhhEF/HCQxhtA88KbIydILFRS
	 5KSgCHtsY16bUrUWv5M5dGAa07Rp0Fzr09Wyyqr8=
Date: Wed, 30 Aug 2023 19:24:43 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Graf <graf@amazon.de>, "Gowans, James" <jgowans@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, iommu@lists.linux.dev,
	kvm <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Message-ID: <20230831022443.GA10414@skinsburskii.>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
 <20230823024500.GA25462@skinsburskii.>
 <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>
 <20230829220740.GA26605@skinsburskii.>
 <82416797-01aa-471a-a737-471297e37c4c@amazon.de>
 <1697efce-665a-43d5-b0be-7c03c0a4d850@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697efce-665a-43d5-b0be-7c03c0a4d850@app.fastmail.com>

On Wed, Aug 30, 2023 at 07:39:18PM -0400, Arnd Bergmann wrote:
> On Wed, Aug 30, 2023, at 03:20, Alexander Graf wrote:
> > On 30.08.23 00:07, Stanislav Kinsburskii wrote:
> >> On Mon, Aug 28, 2023 at 10:50:19PM +0200, Alexander Graf wrote:
> 
> >> Device tree or ACPI are options indeed. However AFAIU in case of DT user
> >> space has to involved into the picture to modify and complie it, while
> >> ACPI isn't flexible or easily extendable.
> >> Also, AFAIU both these standards were designed with passing
> >> hardware-specific data in mind from bootstrap software to an OS kernel
> >> and thus were never really intended to be used for creating a persistent
> >> state accross kexec.
> >> To me, an attempt to use either of them to pass kernel-specific data looks
> >> like an abuse (or misuse) excused by the simplicity of implementation.
> >
> >
> > What I was describing above is that the Linux boot protocol already has 
> > natural ways to pass a DT (arm) or set of ACPI tables (x86) to the 
> > target kernel. Whatever we do here should either piggy back on top of 
> > those natural mechanisms (e.g. /chosen node in DT) or be on the same 
> > level (e.g. pass DT in one register, pass metadata structure in another 
> > register).
> >
> > When it comes to the actual content of the metadata, I'm personally also 
> > leaning towards DT. We already have libfdt inside the kernel. It gives 
> > is a very simple, well understood structured file format that you can 
> > extend, version, etc etc. And the kernel has mechanisms to modify fdt 
> > contents.
> 
> Agreed. This also makes a lot of sense since the fdt format was
> originally introduced for this exact purpose, to be a key-value
> store to pass data from the running kernel to the next one after
> kexec when the original source of the data (originally open
> firmware) is gone. It only turned into the generic way to
> describe embedded systems later on, but both the fdt binary
> format and the kexec infrastructure for manipulating and
> passing the blob should be easy to reuse for additional purposes
> as long as the contents are put into appropriate namespaces that
> don't clash with existing usage.
> 

I see. Using DT instead of introducing another format to pass metadata
is quite tempting.
The only problem I see here is that it enforces a user of x86 host to
use device tree.
I guess such a device tree can be fully constructred in kernel and then
added to kexec parameters by kernel itself thus keeping the such
matadata management independent from user setup.
But then how to combine this in-kernel device tree with the one,
provided by user?
Also, AFAIK user can override device tree via kexec paramaters, so I
guess placing kernel-specific data into a DT, controlled by user, isn't
very reliable.
Is there a way to pass multiple device trees over kexec?
Or should there be an implicit extention to patch user provided DT
with kernel metadata before kexec?

Thanks,
Stanislav

>        Arnd
