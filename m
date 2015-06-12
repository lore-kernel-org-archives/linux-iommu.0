From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] More cleanups and fixes for Intel VT-d
Date: Fri, 12 Jun 2015 22:29:27 +0200
Message-ID: <20150612202927.GK20384@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
	<1434038066.3907.85.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434038066.3907.85.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 11, 2015 at 04:54:26PM +0100, David Woodhouse wrote:
> It looks like the original kdump patch set has basically now been
> rewritten. Perhaps the best thing to do is for Zhenhua to resubmit an
> updated and clean version rather than preserving that
> churn?

Here is a cleaned up version:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git vt-d-kdump

It is based on v4.1-rc7 and in my testing it works as before. I also
implemented support for copying over extended root-entrys and context
tables.

Baoquan, Zhen-Hua, can you please give it a test too? I plan to rebuild
the current x86/vt-d branch with this cleaned up version.


	Joerg
