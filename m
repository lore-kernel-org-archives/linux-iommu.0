From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Feature Request: Ability to decode bus/dma address back into
	physical address
Date: Wed, 2 Aug 2017 15:25:32 -0400
Message-ID: <76c1f638-05a4-1e37-14ad-7f5b21e47028@amd.com>
References: <20170801180415.GB3443@gmail.com>
	<483ecda0-2977-d2ea-794c-320e429d7645@amd.com>
	<20170801190259.GC3443@gmail.com>
	<42c5fe2b-f179-cb71-03d3-7ae991543edb@amd.com>
	<20170801195556.GD3443@gmail.com>
	<77e557d2-aa75-46c4-88a7-cca5448ea08e@amd.com>
	<20170801210105.GE3443@gmail.com>
	<2cd345ee-d5ad-1ad7-508a-86225e65621c@amd.com>
	<20170802044214.GA6285@gmail.com>
	<4a2b004b-ebc2-9331-84c4-4e6672dd7b97@amd.com>
	<20170802164343.GA3105@gmail.com>
	<5ecbb5c2-fe4e-fd84-43b5-67ae06c5a032@amd.com>
	<2f9da712-1559-6593-e512-c0508e21d747@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2f9da712-1559-6593-e512-c0508e21d747-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/08/17 02:42 PM, Robin Murphy wrote:

> FWIW I'm not aware of anything that does exactly what you want (other
> than some trick patches I keep around that only work for arm64), but it
> does come to mind that it ought to be fairly straightforward to give
> dma-debug the ability to dump out the information it already captures.
> It wouldn't be viable for deployment in non-development kernels, but
> it's a idea - for production kernels, the simple answer is probably
> "boot with iommu=off|pt when GPU debugging" anyway.

The genesis of this requirement is that IOMMU is a requirement in a lot 
of new development (for instance, virtualization) and newer systems 
cannot operate with it disabled.

Previously, ya I'd tell umr (our debugger) users to turn it off but 
that's becoming increasingly hard to sell :-)

Right now our tracepoint seems to work but relatively light workloads 
but can become somewhat laggy on higher loads and I fear that on data 
center type loads will become completely unusable.

Tom
