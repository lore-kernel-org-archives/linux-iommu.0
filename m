From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Thu, 23 May 2013 17:36:24 -0700
Message-ID: <1369355784.2080.5.camel@joe-AO722>
References: <1369354931-19373-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1369354931-19373-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-05-24 at 08:22 +0800, Li, Zhen-Hua wrote:
> There is a structure named context_entry used by intel iommu, and there
> are some bit operations on it. Use bit structure may make these operations
> easy.
[]
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
[]
> @@ -221,55 +221,28 @@ get_context_addr_from_root(struct root_entry *root)
>   * 8-23: domain id
>   */
>  struct context_entry {
> -	u64 lo;
> -	u64 hi;
> +	union {
> +		struct {
> +			u64	present:1,

why use struct and union at all?

Why not just:

struct context_entry {
	u64	present:1,
		fpd:1,
		translation_type:2,
		reserved_l:8,
		asr:52;
	u64	aw:3,
		avail:4,
		reserved_h1:1,
		did:16,
		reserved_h2:40;
}; 

> @@ -743,7 +716,8 @@ static void clear_context_table(struct intel_iommu *iommu, u8 bus, u8 devfn)
[]
>  	if (context) {
> -		context_clear_entry(&context[devfn]);
> +		context[devfn].lo = 0;
> +		context[devfn].hi = 0;

		memset(&context[devfn], 0, sizeof(...))
