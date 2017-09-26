From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Check whether page is already
 mapped
Date: Tue, 26 Sep 2017 16:49:52 +0300
Message-ID: <e59eb818-4edf-f3a2-947a-bc21507b0b85@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
 <a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx@gmail.com>
 <20170926110636.GA23108@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170926110636.GA23108@ulmo>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26.09.2017 14:06, Thierry Reding wrote:
> On Wed, Jul 05, 2017 at 07:29:46PM +0300, Dmitry Osipenko wrote:
>> Due to a bug, multiple devices may try to map the same IOVA region. We can
>> catch that case by checking that 'VALID' bit of the GART's page entry is
>> unset prior to mapping of the page.
> 
> Due to what bug? Sounds to me like access to the GART should be
> exclusive, so that only a single driver can ever access it.
> 

Actually, there are a lot of peripherals behind the GART. But yes, probably we
would use it exclusively for the GPU allocations.

In a case of the GPU allocations there could be a bug in the allocation code
(drm_mm_scan) that would cause re-mapping of the already mapped pages, we would
be able to catch such a bug.

-- 
Dmitry
