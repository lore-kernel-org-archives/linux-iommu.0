From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Fri, 18 Mar 2016 12:33:44 +0100
Message-ID: <20160318113344.GE7817@pd.tnic>
References: <56E759C3.5040707@amd.com> <20160315104017.GA4559@pd.tnic>
	<20160315105318.GU6344@twins.programming.kicks-ass.net>
	<56EBA92D.7010906@amd.com> <20160318090441.GA7817@pd.tnic>
	<56EBC5CD.7070701@amd.com> <20160318092910.GC7817@pd.tnic>
	<56EBD31F.6050206@amd.com> <20160318103918.GD7817@pd.tnic>
	<20160318111100.GG2195@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160318111100.GG2195-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 18, 2016 at 12:11:01PM +0100, Joerg Roedel wrote:
> On Fri, Mar 18, 2016 at 11:39:18AM +0100, Borislav Petkov wrote:
> > Yeah, so arch/x86/include/asm/ has all the x86-specific stuff which is
> > not exported to userspace, so moving stuff there makes sense to me.
> 
> While the AMD IOMMU is only available on x86 today, there is nothing
> x86-specific in its architecture, so I don't think its header files
> belong to arch/x86.
> 
> By that reasoning we could also move all of the intel gpu stuff to
> arch/x86. But we don't do it, because it doesn't make sense and because
> it doesn't belong there.

And according to that argument of yours, we should move everything
which is not too close to the arch it is being used on, to generic
include/linux/. Because it might possibly get used some day by other
arches. Yeah right.

And looking at include/linux - it looks like a dumping ground for
headers. :-\

I guess anything is better than putting non-generic enough stuff in
include/linux/. Maybe drivers/include or something in that direction
would be better...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
