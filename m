From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
Date: Mon, 6 Jan 2014 14:28:33 +0000
Message-ID: <20140106142833.GC10449@mudshark.cambridge.arm.com>
References: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388750486-5060-1-git-send-email-yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yifan Zhang <yifan.zhangm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 03, 2014 at 12:01:26PM +0000, Yifan Zhang wrote:
> From: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Pgd/pud entry should be filled only once when their next level pud/pmd
> created, the value should be pud/pmd start address, while in current
> code, pgd/pud entry is filled every time when pud/pmd walk occurs,
> the value is pud/pmd start address + iova pud/pmd index , this is
> incorrect; Besides, when pud/pmd are created, we need to add pud/pmd
> index, then pass to next level, while in currect code, if a new pud/pmd
> created, their iova pud/pmd index is not taken into account, only
> existing pud/pmd do. This patch change pud/pmd entry fill sequence,
> fixes the 2 bugs.
> 
> Signed-off-by: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Thanks Yifan, this looks good to me. It's strange that I got the pte
handling correct, but screwed up the equivalent pmd and pud code!

Will
