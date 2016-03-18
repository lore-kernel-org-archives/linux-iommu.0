From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V5 02/10] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Fri, 18 Mar 2016 16:09:33 +0700
Message-ID: <56EBC5CD.7070701@amd.com>
References: <20160312132224.GI6344@twins.programming.kicks-ass.net>
	<56E64B68.3090505@amd.com>
	<20160314095856.GL6344@twins.programming.kicks-ass.net>
	<56E6BE7E.8010807@amd.com> <20160314141945.GE15800@pd.tnic>
	<20160314163913.GO6344@twins.programming.kicks-ass.net>
	<56E759C3.5040707@amd.com> <20160315104017.GA4559@pd.tnic>
	<20160315105318.GU6344@twins.programming.kicks-ass.net>
	<56EBA92D.7010906@amd.com> <20160318090441.GA7817@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160318090441.GA7817-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Boris,

On 03/18/2016 04:04 PM, Borislav Petkov wrote:
> On Fri, Mar 18, 2016 at 02:07:25PM +0700, Suravee Suthikulpanit wrote:
>> Actually the exposed APIs (in both files) are from the AMD IOMMU driver,
>> which is not necessary x86-specific. They mostly use struct pci_dev, which
>> is also arch-agnostic. It is correct that the current IOMMU IP is only
>> available in x86 systems. However, if AMD plans to use the IOMMU IP in the
>> ARM-based processors in the future, putting these into
>> include/linux/amd-iommu.h would work better.
>
> Let's wait until AMD does that then. Moving the header is the easiest part.
>

But the whole point is that since we are moving it to consolidate these 
duplicated declarations, I think we should just put it in the most 
common place. The include/linux/amd-iommu.h file is already there. It's 
not like we have to create a brand new file, and then having to move it 
later.

Regards,
Suravee
