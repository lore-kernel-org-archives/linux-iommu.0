From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V4 5/6] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Mon, 22 Feb 2016 15:07:41 +0100
Message-ID: <20160222140741.GH6357@twins.programming.kicks-ass.net>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1455182127-17551-6-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160218131853.GU6357@twins.programming.kicks-ass.net>
 <56CAC01F.8090800@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CAC01F.8090800@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: joro@8bytes.org, bp@alien8.de, mingo@redhat.com, acme@kernel.org, andihartmann@freenet.de, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 22, 2016 at 03:00:31PM +0700, Suravee Suthikulpanit wrote:
> >So I really don't have time to review new muck while I'm hunting perf
> >core fail, but Boris made me look at this.
> >
> >This is crazy, if you have multiple IOMMUs then create an event per
> >IOMMU, do _NOT_ fold them all into a single event.
> 
> These are system-wide events, which are programmed on every IOMMU the same
> way. I am not sure what you meant by creating an event per IOMMU. Do you
> mean I should create internal per-IOMMU struct perf_event for each event?

No, I meant to expose each IOMMU individually to userspace, as a
separate device.

Is there never a case to profile just one of the IOMMUs ?
