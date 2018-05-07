From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Mon, 7 May 2018 18:46:48 +0300
Message-ID: <c4cd6692-2010-ec15-f541-b4709932ac82@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
	<f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
	<20180427100202.GO30388@ulmo> <20180507075920.GA18595@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180507075920.GA18595-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07.05.2018 10:59, Joerg Roedel wrote:
> On Fri, Apr 27, 2018 at 12:02:02PM +0200, Thierry Reding wrote:
>> Joerg, I've gone over the git log and header files and I see no mention
>> of why the TLB flush interface isn't used for mapping. Do you recall any
>> special reasons why the same shouldn't be applied for mapping? Would you
>> accept any patches doing this?
> 
> Yeah, the reason was that we assumed that only emulated IOMMUs ever need
> flushing in the mapping path, and there is no reason to optimize for
> that. Especially when a call to iotlb_sync() in the mapping path would
> hurt most other users.
> 
> Does the tegra-gart actually need it too?

Tegra-GART is exactly an emulated IOMMU, it doesn't have anything like TLB and
it's simply a remapping table. What is actually needed for the GART - is to make
sure that the remapping table modifications reach GART HW before anything tries
to touch the modified page entries. Presumable there is some kind of a HW buffer
that accumulates multiple registers writes and issues them in bursts to improve
performance, read-after-write is the way to flush that buffer.
