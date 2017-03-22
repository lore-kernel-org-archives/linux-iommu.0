From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/3] iommu/ipmmu-vmsa: r8a7796 support V3
Date: Wed, 22 Mar 2017 15:23:12 +0100
Message-ID: <20170322142312.GB7266@8bytes.org>
References: <148929710090.20744.10912918031085568693.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <148929710090.20744.10912918031085568693.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Magnus,

On Sun, Mar 12, 2017 at 02:38:20PM +0900, Magnus Damm wrote:
> iommu/ipmmu-vmsa: r8a7796 support V3
> 
> [PATCH v3 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding
> [PATCH v3 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
> [PATCH v3 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code

I just tried to apply a few of your patch-sets, but failed because they
don't apply cleanly and it is not clear what the dependencies are and in
which order they need to be applied.

So for now I skipped all ipmmu-vmsa patches that are currently in my
inbox. Please rebase your different series to v4.11-rc3 and resend them
in the right order, with all Reviewed-bys and other tags that people
gave you included. Then I am taking another look into applying them.


Thanks,

	Joerg
