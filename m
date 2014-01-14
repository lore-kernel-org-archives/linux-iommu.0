From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: change pud/pmd entry fill sequence
Date: Tue, 14 Jan 2014 10:07:37 +0000
Message-ID: <20140114100737.GA25681@mudshark.cambridge.arm.com>
References: <1388750486-5060-1-git-send-email-yifan.zhangm@gmail.com>
 <20140106142833.GC10449@mudshark.cambridge.arm.com>
 <CAGZxSSSjhqg4vnw__qoW0zLibEG_1FChrHWFFUorkV65Sq0ogg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAGZxSSSjhqg4vnw__qoW0zLibEG_1FChrHWFFUorkV65Sq0ogg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yifan Zhang <yifan.zhangm@gmail.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, Yifan Zhang <zhangyf@marvell.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 14, 2014 at 09:02:49AM +0000, Yifan Zhang wrote:
> It seems this patch is still not merged yet, any concerns about it ?

No, I was planning to send it at -rc1 with a CC stable.

Will
