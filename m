From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/tegra: gart: Optionally check for
 overwriting of page mappings
Date: Thu, 12 Oct 2017 17:27:26 +0300
Message-ID: <7dc66d59-3904-d1f8-3941-f9a534ff899a@gmail.com>
References: <cover.1507078770.git.digetx@gmail.com>
 <7eea4a30b0f4fdbe14351cf2c6cf537365080d2d.1507078770.git.digetx@gmail.com>
 <20171010095342.jyvzl2zex2pynqvv@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171010095342.jyvzl2zex2pynqvv-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10.10.2017 12:53, Joerg Roedel wrote:
> On Wed, Oct 04, 2017 at 04:02:31AM +0300, Dmitry Osipenko wrote:
>> Due to a bug in IOVA allocator, page mapping could accidentally overwritten.
>> We can catch this case by checking 'VALID' bit of GART's page entry prior to
>> mapping of a page. Since that check introduces a noticeable performance
>> impact, it should be enabled explicitly by a new CONFIG_TEGRA_IOMMU_GART_DEBUG
>> option.
> 
> Which bug in the IOVA allocator are you talking about?
> 

I'm not talking about any specific bug, but in general if allocator re-maps
already mapped region or unmaps the wrong-and-used region. I had those bug-cases
during of development of the 'scattered' graphics allocations for Tegra20.
