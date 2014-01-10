From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: fix compilation error for IA64 platform
Date: Fri, 10 Jan 2014 09:39:01 +0800
Message-ID: <52CF4F35.3080805@linux.intel.com>
References: <1388989107-4795-20-git-send-email-jiang.liu@linux.intel.com>
	<1389171427-26223-1-git-send-email-jiang.liu@linux.intel.com>
	<20140109115501.GI29041@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140109115501.GI29041-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Thanks Joerg! Sorry for the inconvenience.

On 2014/1/9 19:55, Joerg Roedel wrote:
> On Wed, Jan 08, 2014 at 04:57:07PM +0800, Jiang Liu wrote:
>> Hi Joerg,
>> 	Could you please help to fold this into "[21/22] iommu/vt-d,
>> trivial: clean sparse warnings"?
> 
> Okay, I folded the two patches in, but that is something I'd like to
> avoid because it requires a rebase. So next time please just send a
> follow-up patch to my x86/vt-d branch to fix things up.
> 
> 
> 	Joerg
> 
> 
