From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu: Add domain window handling functions
Date: Wed, 6 Feb 2013 11:26:08 +0100
Message-ID: <20130206102607.GB2634@8bytes.org>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
	<1359983924-28952-5-git-send-email-joro@8bytes.org>
	<CALRxmdCiSZgoqd8tp90kPCdA=s7SWZCTwKsFnWu7S5=U7+eRLQ@mail.gmail.com>
	<20130204185650.GP25591@8bytes.org>
	<CALRxmdD9Ock04AoUtF9FT_uY5C5Eb7cSPmtCM6WK=StNB_iYkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALRxmdD9Ock04AoUtF9FT_uY5C5Eb7cSPmtCM6WK=StNB_iYkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 04, 2013 at 05:31:51PM -0600, Stuart Yoder wrote:
> On Mon, Feb 4, 2013 at 12:56 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > Okay. So if your architecture supports sizes over 2^32 then size_t
> > probably is already 64bits, right?
> 
> No, on a 32-bit platform size_t would generally be 32-bits.  But the PAMU
> is independent of that.   I think we should just make it a u64.

Okay, you can find the patches in the 'core' branch of the iommu-tree.
They are also included in my next branch. You can use them now to base
the PAMU patches on it.


	Joerg
