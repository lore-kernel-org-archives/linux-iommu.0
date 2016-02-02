From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Tue, 2 Feb 2016 10:49:11 -0500
Message-ID: <56B0CFF7.80907@compro.net>
References: <20160114000520.GA2449@x1.redhat.com>
	<5697AAD8.1000105@compro.net> <20160120153823.GG18805@8bytes.org>
	<20160120154658.GH18805@8bytes.org> <569FB013.4050709@compro.net>
	<20160120161904.GI18805@8bytes.org> <569FCFC8.2000606@compro.net>
	<20160120182602.GJ18805@8bytes.org> <56A0F03C.8010109@compro.net>
	<56A0F221.10502@compro.net> <20160121223958.GL18805@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160121223958.GL18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 01/21/2016 05:39 PM, Joerg Roedel wrote:
> On Thu, Jan 21, 2016 at 09:58:41AM -0500, Mark Hounschell wrote:
>>> Here ya go.
>>>
>>> 150952f96941cb13371770ce0cf47906647d8bba is the first bad commit
>>> commit 150952f96941cb13371770ce0cf47906647d8bba
>>> Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>>> Date:   Tue Oct 20 17:33:35 2015 +0200
>>>
>>>      iommu/amd: Do not iterate over alias-list in __[attach|detach]_device
>>>
>>>      The alias list is handled aleady by iommu core code. No need
>>>      anymore to handle it in this part of the AMD IOMMU code
>>>
>>>      Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>>>
>>> :040000 040000 334ffdc0d7ff9389478d3ce6096eb81227d8eafc
>>> cb6fce5d7e94ce3e44a6a64092ba8eb32dd0978b M      drivers
>>>
>>
>> FYI, this commit also had tons of IO_PAGE_FAULTS booting but
>> eventually all the disks but the 2 in question actually ended up
>> being mounted.
>
> I see, thanks for your effort. I'll take a closer look and hopefully
> come up with a fix for you to test.
>
>
> 	Joerg
>
>

Hey Joerg,

Just wondering if this issue is still being considered?

Regards
Mark
