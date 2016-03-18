From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
 perf_event_amd_iommu header
Date: Fri, 18 Mar 2016 10:29:10 +0100
Message-ID: <20160318092910.GC7817@pd.tnic>
References: <20160314095856.GL6344@twins.programming.kicks-ass.net>
 <56E6BE7E.8010807@amd.com>
 <20160314141945.GE15800@pd.tnic>
 <20160314163913.GO6344@twins.programming.kicks-ass.net>
 <56E759C3.5040707@amd.com>
 <20160315104017.GA4559@pd.tnic>
 <20160315105318.GU6344@twins.programming.kicks-ass.net>
 <56EBA92D.7010906@amd.com>
 <20160318090441.GA7817@pd.tnic>
 <56EBC5CD.7070701@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EBC5CD.7070701@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, joro@8bytes.org, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, vw@iommu.org, labbott@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 18, 2016 at 04:09:33PM +0700, Suravee Suthikulpanit wrote:
> But the whole point is that since we are moving it to consolidate these
> duplicated declarations, I think we should just put it in the most common
> place. The include/linux/amd-iommu.h file is already there. It's not like we
> have to create a brand new file, and then having to move it later.

Strictly speaking, it was wrong to put it there in the first place as it
is x86-specific.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
