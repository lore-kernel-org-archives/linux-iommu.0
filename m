From: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
	after finding it
Date: Mon, 13 Feb 2017 13:50:29 +0200
Message-ID: <CAPD2p-=pVgJvVY7GFPWWqj9wp96JSsxD-SO5oNXxq9ag2wWT0Q@mail.gmail.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
	<CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
	<20170213112728.GH1512@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170213112728.GH1512-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, Volodymyr Babchuk <vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrii Anisov <andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleksandr Andrushchenko <andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, al1img <al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Artem Mygaiev <joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 13, 2017 at 1:27 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Mon, Feb 13, 2017 at 01:07:02PM +0200, Oleksandr Tyshchenko wrote:
>> Any comments?
>
> Looks fine to me, but I don't think it's urgent and I already sent my
> SMMU pull for 4.11. I'll send this as a fix after the merge window.
OK. Thank you.

>
> I suspect we need something similar for io-pgtable-arm-v7s.c, too.
Agree. On the whole I will be able to make similar patch for arm-v7s,
but I won't be 100% sure
since I don't have any boards where arm-v7s compatible IOMMU installed.

Shall I make patch for arm-v7s too?

>
> Will



-- 
Regards,

Oleksandr Tyshchenko
