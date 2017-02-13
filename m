From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v1] iommu/io-pgtable-arm: Check for leaf entry right
 after finding it
Date: Mon, 13 Feb 2017 11:27:28 +0000
Message-ID: <20170213112728.GH1512@arm.com>
References: <1486648600-27457-1-git-send-email-olekstysh@gmail.com>
 <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPD2p-=TtT9ZHpLu8w9jUdKR5u6JG_BGtz0BDDKejmWS-jQ9WQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Volodymyr Babchuk <vlad.babchuk@gmail.com>, joro@8bytes.org, iommu@lists.linux-foundation.org, Andrii Anisov <andrii.anisov@gmail.com>, Oleksandr Andrushchenko <andr2000@gmail.com>, al1img <al1img@gmail.com>, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, Artem Mygaiev <joculator@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 13, 2017 at 01:07:02PM +0200, Oleksandr Tyshchenko wrote:
> Any comments?

Looks fine to me, but I don't think it's urgent and I already sent my
SMMU pull for 4.11. I'll send this as a fix after the merge window.

I suspect we need something similar for io-pgtable-arm-v7s.c, too.

Will
