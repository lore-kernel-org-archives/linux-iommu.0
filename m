From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Wed, 20 Jan 2016 11:04:35 -0500
Message-ID: <569FB013.4050709@compro.net>
References: <56957209.1080202@compro.net>
	<20160113030950.GB11902@dhcp-128-28.nay.redhat.com>
	<56966244.80700@compro.net> <20160114000520.GA2449@x1.redhat.com>
	<5697AAD8.1000105@compro.net> <20160120153823.GG18805@8bytes.org>
	<20160120154658.GH18805@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160120154658.GH18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/20/2016 10:46 AM, Joerg Roedel wrote:
> On Wed, Jan 20, 2016 at 04:38:23PM +0100, Joerg Roedel wrote:
>> On Thu, Jan 14, 2016 at 09:04:08AM -0500, Mark Hounschell wrote:
>>> OK, I verified the 2 disks are hanging off the Marvel chips.
>>> Here is the dmesg from booting with your patch and the 2
>>> disks not showing up.
>>
>> Does it boot with iommu=soft?
>
> Something also worth trying is amd_iommu=fullflush (without iommu=soft).
> Would be great if you find the time to test these two parameters and
> report back.
>
>

amd_iommu=fullflush does not help.

iommu=soft allows it to boot

Mark
