From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/tegra: gart: Optionally check for
	overwriting of page mappings
Date: Fri, 13 Oct 2017 10:38:49 +0200
Message-ID: <20171013083848.GA29513@8bytes.org>
References: <cover.1507078770.git.digetx@gmail.com>
	<7eea4a30b0f4fdbe14351cf2c6cf537365080d2d.1507078770.git.digetx@gmail.com>
	<20171010095342.jyvzl2zex2pynqvv@8bytes.org>
	<7dc66d59-3904-d1f8-3941-f9a534ff899a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7dc66d59-3904-d1f8-3941-f9a534ff899a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 12, 2017 at 05:27:26PM +0300, Dmitry Osipenko wrote:
> I'm not talking about any specific bug, but in general if allocator re-maps
> already mapped region or unmaps the wrong-and-used region. I had those bug-cases
> during of development of the 'scattered' graphics allocations for Tegra20.

The dma-iommu code does not re-map already mapped regions and it doesn't
unmap wrong regions. If it does it should be reported and fixed.

So if you hit any bug there, please report it so that it can be fixed.


Thanks,

	Joerg
