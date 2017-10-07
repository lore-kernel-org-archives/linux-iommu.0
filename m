From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] lib: Adjustments for 11 function implementations
Date: Sat, 7 Oct 2017 19:46:52 +0200
Message-ID: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Daniel Mentz <danielmentz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Lars Ellenberg <lars.ellenberg@linbit.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Philipp Reisner <philipp.reisner@linbit.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Oct 2017 19:39:29 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  test: Delete five error messages for a failed memory allocation
  Improve a size determination in seven functions

 lib/dma-debug.c                 |  2 +-
 lib/flex_array.c                |  4 ++--
 lib/genalloc.c                  |  2 +-
 lib/lru_cache.c                 |  2 +-
 lib/reed_solomon/reed_solomon.c |  2 +-
 lib/test_kasan.c                |  5 ++---
 lib/test_kmod.c                 | 10 +++-------
 lib/test_list_sort.c            |  9 +++------
 8 files changed, 14 insertions(+), 22 deletions(-)

-- 
2.14.2
