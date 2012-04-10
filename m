From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
Date: Tue, 10 Apr 2012 12:34:35 -0700
Message-ID: <4F848B4B.5000308@samsung.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com> <20120315111227.GA2384@amd.com> <4F61FF1D.5000502@samsung.com> <4F630841.2070307@linaro.org> <4F63A6F6.9050506@samsung.com> <20120318132746.GL26973@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120318132746.GL26973@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Younglak Kim' <younglak1004.kim@samsung.com>, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel wrote:
> On Fri, Mar 16, 2012 at 01:47:50PM -0700, Kukjin Kim wrote:
>> Anyway Joerg, how do you want to handle this? Do you want to pick up
>> 1/2/3 all of them in your tree? If so, 2nd patch should be on top of
>> some samsung topic stuff.
>
> Since patch 2 only applies to the Samsung tree, it is best to carry
> this in your tree for merging. Feel free to add my Acked-by to patch 3.
> But any further patches for the Exynos IOMMU drivers should go through
> my tree after it is merged.
>
Hi Joerg,

I applied 1st and 2nd patches in my tree.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-samsung-iommu

and my -next.

So please go ahead for 3rd patch in your tree. Note that if you need 1st 
and 2nd patches for your tree, please merge the 
'next/cleanup-samsung-iommu' branch in my tree. If not, will happen 
useless conflicts.

If any problems, please let me know.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
