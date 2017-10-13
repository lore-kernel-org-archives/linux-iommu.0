From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/tegra: gart: Optionally check for
	overwriting of page mappings
Date: Fri, 13 Oct 2017 15:52:52 +0300
Message-ID: <71a0e4c6-714f-cb0d-57f6-250c0c1cd40a@gmail.com>
References: <cover.1507078770.git.digetx@gmail.com>
	<7eea4a30b0f4fdbe14351cf2c6cf537365080d2d.1507078770.git.digetx@gmail.com>
	<20171010095342.jyvzl2zex2pynqvv@8bytes.org>
	<7dc66d59-3904-d1f8-3941-f9a534ff899a@gmail.com>
	<20171013083848.GA29513@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171013083848.GA29513-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13.10.2017 11:38, Joerg Roedel wrote:
> On Thu, Oct 12, 2017 at 05:27:26PM +0300, Dmitry Osipenko wrote:
>> I'm not talking about any specific bug, but in general if allocator re-maps
>> already mapped region or unmaps the wrong-and-used region. I had those bug-cases
>> during of development of the 'scattered' graphics allocations for Tegra20.
> 
> The dma-iommu code does not re-map already mapped regions and it doesn't
> unmap wrong regions. If it does it should be reported and fixed.
> 

Certainly iommu_map_sg doesn't perform itself any debug checks that I'm
proposing to add to the GART.

Yet we don't use GART in the mainline, right now you may take a look at the WIP
patches here:

https://github.com/grate-driver/linux/commit/9853371164a7f1b5698caee476e7cffe1b446afa

https://github.com/grate-driver/linux/commit/ea1fca4ac932464e7907a7ada8ea2698cab8db65

> So if you hit any bug there, please report it so that it can be fixed.
> 
