From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
 perf_event_amd_iommu header
Date: Fri, 18 Mar 2016 12:11:01 +0100
Message-ID: <20160318111100.GG2195@8bytes.org>
References: <20160314163913.GO6344@twins.programming.kicks-ass.net>
 <56E759C3.5040707@amd.com>
 <20160315104017.GA4559@pd.tnic>
 <20160315105318.GU6344@twins.programming.kicks-ass.net>
 <56EBA92D.7010906@amd.com>
 <20160318090441.GA7817@pd.tnic>
 <56EBC5CD.7070701@amd.com>
 <20160318092910.GC7817@pd.tnic>
 <56EBD31F.6050206@amd.com>
 <20160318103918.GD7817@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160318103918.GD7817@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, vw@iommu.org, labbott@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 18, 2016 at 11:39:18AM +0100, Borislav Petkov wrote:
> Yeah, so arch/x86/include/asm/ has all the x86-specific stuff which is
> not exported to userspace, so moving stuff there makes sense to me.

While the AMD IOMMU is only available on x86 today, there is nothing
x86-specific in its architecture, so I don't think its header files
belong to arch/x86.

By that reasoning we could also move all of the intel gpu stuff to
arch/x86. But we don't do it, because it doesn't make sense and because
it doesn't belong there.


Regards,

	Joerg
