From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v1 0/2] Misc fixes for ARM page table allocator
	(long/short descriptor format)
Date: Thu, 16 Mar 2017 11:19:30 +0000
Message-ID: <9c726317-6669-91d9-ff42-9ad47c144a3e@arm.com>
References: <1488198626-1884-1-git-send-email-olekstysh@gmail.com>
	<CAPD2p-=3Q7KKct29kjSi0=_-R7e3L5sgC-N4zS=BDa1vGc8uuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAPD2p-=3Q7KKct29kjSi0=_-R7e3L5sgC-N4zS=BDa1vGc8uuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Volodymyr Babchuk <vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andrii Anisov <andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleksandr Andrushchenko <andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, al1img <al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Artem Mygaiev <joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 16/03/17 09:19, Oleksandr Tyshchenko wrote:
> Hi, all.
> 
> Any comments?

Er, no, but in a good way ;)

Patches look fine to me, and I see Will's already queued them anyway.

Thanks for the respin, and apologies for losing it in my inbox!

Robin.

> 
> On Mon, Feb 27, 2017 at 2:30 PM, Oleksandr Tyshchenko
> <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi.
>>
>> There is a small patch series which contains the same fix for both
>> descriptor formats based on the preceding RFC patches:
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020411.html
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020477.html
>>
>> Oleksandr Tyshchenko (2):
>>   iommu/io-pgtable-arm: Check for leaf entry before dereferencing it
>>   iommu/io-pgtable-arm-v7s: Check for leaf entry before dereferencing it
>>
>>  drivers/iommu/io-pgtable-arm-v7s.c | 6 +++++-
>>  drivers/iommu/io-pgtable-arm.c     | 6 +++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> 
> 
