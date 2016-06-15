From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Wed, 15 Jun 2016 16:05:29 +0200
Message-ID: <20160615140529.GO26566@8bytes.org>
References: <57604810.1070504@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57604810.1070504-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Daniel Walker <danielwa-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: "xe-kernel-qGaTmy9+pjmU+GOnkdjqUdBPR1lH4CV8@public.gmane.org" <xe-kernel-qGaTmy9+pjmU+GOnkdjqUdBPR1lH4CV8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Nikunj Kela (nkela)" <nkela-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 14, 2016 at 11:08:16AM -0700, Daniel Walker wrote:
> I noticed that you responded to these changes saying they were applied to
> your tree,
> 
> https://lkml.org/lkml/2015/5/29/468
> 
> but I haven't not seen them show up in mainline. Did they get removed for
> some reason, or misplaced ? Or are they in mainline and I just missed them ?

These patches turned out to be utterly broken. After writing more than
20 fixes for them, I was urged to re-write the stuff from scratch to get
a clean history of the feature. So I dropped the patches from Li and
queued my re-write instead.


	Joerg
