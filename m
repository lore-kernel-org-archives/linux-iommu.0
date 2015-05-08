From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
Date: Fri, 8 May 2015 17:22:10 +0900
Message-ID: <CAAFQd5A2aN_nMtUY52GMbmRWP_ibzn-Nw0sRcZtQBN=25UKa1Q@mail.gmail.com>
References: <1429530224-24719-1-git-send-email-tfiga@chromium.org>
 <CAGS+omAPLMnwtMNhiakwc7Tn-yeMjdjiy3p=bxuj9AUQUrCO=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAGS+omAPLMnwtMNhiakwc7Tn-yeMjdjiy3p=bxuj9AUQUrCO=A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 23, 2015 at 6:09 PM, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Mon, Apr 20, 2015 at 7:43 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> To flush created mappings, current mapping code relies on the fact that
>> during unmap the driver zaps every IOVA being unmapped and that it is
>> enough to zap a single IOVA of page table to remove the entire page
>> table from IOMMU cache. Based on these assumptions the driver was made to
>> simply zap the first IOVA of the mapping being created. This is enough
>> to invalidate first page table, which could be shared with another
>> mapping (and thus could be already present in IOMMU cache), but
>> unfortunately it does not do anything about the last page table that
>> could be shared with other mappings as well.
>>
>> Moreover, the flushing is performed before page table contents are
>> actually modified, so there is a race between the CPU updating the page
>> tables and hardware that could be possibly running at the same time and
>> triggering IOMMU look-ups, which could bring back the page tables back
>> to the cache.
>>
>> To fix both issues, this patch makes the mapping code zap first and last
>> (if they are different) IOVAs of new mapping after the page table is
>> updated.
>>
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
>
> You probably want to remove the "CHROMIUM: " label in the subject.

Sorry, I removed gerrit tags, but hurrying up too much, I missed the
label. I see, though, that Joerg has applied this patch already with
this fixed up. Thanks.

Best regards,
Tomasz
