From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 1/5] perf/amd/iommu: Consolidate and move
	perf_event_amd_iommu header
Date: Wed, 10 Feb 2016 20:00:30 +0100
Message-ID: <20160210190030.GA2595@pd.tnic>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1455058435-8716-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160210164116.GG23914@pd.tnic> <56BB84AC.5080605@amd.com>
	<20160210185146.GA11024@pd.tnic> <56BB87EB.60700@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BB87EB.60700-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 11, 2016 at 01:56:43AM +0700, Suravee Suthikulpanit wrote:
> Ah.. agree then ;) So, I should branch off that tree of yours with the file
> already moved. Could you point me to it?

Not my tree, tip/master:

http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git, the master branch.

Just rediff your stuff ontop.

HTH.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
