From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Fri, 18 May 2018 10:20:39 -0500
Message-ID: <4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
	<152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
	<ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
	<5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
	<20180515134603.GD18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180515134603.GD18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/15/2018 08:46 AM, Joerg Roedel wrote:
> On Mon, May 14, 2018 at 03:00:50PM -0500, Gary R Hook wrote:
>> This was brought up a few weeks ago in, I believe, version 3 of this patch.
>> That question was discussed (because that's what I did the first time out),
>> and _someone_ _else_ asked about why I didn't just do it the way I've done
>> it here.
> 
> You don't have this problem if you put the code in amd_iommu.c in an
> IOMMU_DEBUGFS ifdef.

Of course. My preference, however, is a separate file to avoid size 
creep. That's why I've done it this way.

To whit: there have been threads discussing the 
advisability/acceptability of using #ifdefs for debug code. My take-away 
was to avoid them. Perhaps I misunderstood.

So: I don't understand your comment. Is this an observation, or is it an 
imperative statement? I'd like for a maintainer to clearly indicate what 
is acceptable, and I'll do it.
