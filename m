From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3] iommu/amd: Add logic to decode AMD IOMMU event flag
Date: Tue, 9 Apr 2013 21:52:31 +0200
Message-ID: <20130409195231.GI6858@8bytes.org>
References: <1364947610-3327-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130409094132.GD6858@8bytes.org> <51642FCD.8080606@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51642FCD.8080606-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2013 at 10:12:13AM -0500, Suthikulpanit, Suravee wrote:
> These messages are not "high volumn".  What I am trying to achieve
> is for users to be able to just send the errors to developers once
> they are encountered without having to tell them to go back and
> reboot with the "amd_iommu=verbose". In facts, they often difficult
> to reproduce from my experience.  This should reduce the amount of
> communications and efforts required to debug the issue.

More than one line per io-page-fault _is_ high volume. The current code
that prints only one line was sufficient to debug all related AMD IOMMU
driver problems in the past 5 years I am working on this driver.

What makes sense is decoding the flags field in the kernel. Doing this
by hand always costs some time that could be saved this way. If your
patch does more than that by default I am not going to merge it.


	Joerg
