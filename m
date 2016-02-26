From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Fri, 26 Feb 2016 17:23:19 +0100
Message-ID: <20160226162319.GH22747@8bytes.org>
References: <569FB013.4050709@compro.net> <20160120161904.GI18805@8bytes.org>
	<569FCFC8.2000606@compro.net> <20160120182602.GJ18805@8bytes.org>
	<56A0F03C.8010109@compro.net> <56A0F221.10502@compro.net>
	<20160121223958.GL18805@8bytes.org> <56B0CFF7.80907@compro.net>
	<20160216162455.GX18805@8bytes.org> <56C35D1A.9080307@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C35D1A.9080307-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mark,

On Tue, Feb 16, 2016 at 12:32:10PM -0500, Mark Hounschell wrote:
> Thanks, I'll be standing by.

I am pretty sure I have seen a dmesg from your machine when it runs into
this issue, but somehow I can't find it anymore.

Can you please boot a v4.5-rc5 kernel with iommu enabled and
'amd_iommu_dump' on the kernel command line and send me dmesg after
boot again?


Thanks a lot,


       Joerg
