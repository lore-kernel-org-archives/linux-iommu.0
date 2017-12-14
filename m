From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/2] mm: Add kernel MMU notifier to manage IOTLB/DEVTLB
Date: Wed, 13 Dec 2017 22:28:37 -0800
Message-ID: <4466eac3-c4f5-47e4-e568-912a560240c1@intel.com>
References: <1513213366-22594-1-git-send-email-baolu.lu@linux.intel.com>
 <1513213366-22594-2-git-send-email-baolu.lu@linux.intel.com>
 <a98903c2-e67c-a0cc-3ad1-60b9aa4e4c93@huawei.com>
 <5A31F232.90901@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5A31F232.90901@linux.intel.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Bob Liu <liubo95@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Vegard Nossum <vegard.nossum@oracle.com>, Andy Lutomirski <luto@kernel.org>, Huang Ying <ying.huang@intel.com>, Matthew Wilcox <willy@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kees Cook <keescook@chromium.org>, "xieyisheng (A)" <xieyisheng1@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 12/13/2017 07:38 PM, Lu Baolu wrote:
> 2. When vmalloc/vfree interfaces are called, the page mappings
>     for kernel memory might get changed. And current code calls
>     flush_tlb_kernel_range() to flush CPU TLBs only. The IOTLB or
>     DevTLB will be stale compared to that on the cpu for kernel
>     mappings.

What's the plan to deal with all of the ways other than vmalloc() that
the kernel changes the page tables?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
