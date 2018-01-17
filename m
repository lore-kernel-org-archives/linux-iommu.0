From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/msm: Claim bus ops on probe
Date: Wed, 17 Jan 2018 14:05:21 +0000
Message-ID: <fc884e48-bf80-23a7-8275-209950e0ef34@arm.com>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
	<20180117133331.vidtyduiu7zr3fwc@8bytes.org>
	<bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
	<20180117135356.GQ28161@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180117135356.GQ28161-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/01/18 13:53, Joerg Roedel wrote:
> Hi Robin,
> 
> On Wed, Jan 17, 2018 at 01:39:18PM +0000, Robin Murphy wrote:
>> Oops, patch #2 of this series will break the build, as it was accidentally
>> based on an older branch missing the Renesas IPMMU updates.
> 
> So patch #2 needs the ipmmu-patch from your v2 post to build? I am a bit
> confused...
> 
>> Please see v2 [1] - I'm still hoping for confirmation from the Renesas
>> folks, but it *should* be fine...
> 
> I can apply the patches again from your v2 post, thats fine, I just want
> to understand the dependencies first.

The IOMMU_OF_DECLARE() in ipmmu-vmsa.c added in 4.15 is missed by the 
prototype change in (4.14-based) v1 2/2 - by applying v2 2/3 on top of 
the two v1 patches you will end up with an extra NULL argument there 
which will then fail to compile. v2 3/3 supersedes v1 2/2 by removing 
that one as well. This is entirely my fault for hacking out some quick 
patches on top of unrelated development work instead of creating a fresh 
branch...

>> Incidentally, per your other mail, these changes also makes Jeffy's "Only do
>> IOMMU lookup for available ones" patch obsolete.
> 
> Okay, thanks for letting me know.

Cheers,
Robin.
