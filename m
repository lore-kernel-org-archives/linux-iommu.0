Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A818C03F;
	Mon,  8 Dec 2025 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765169829; cv=none; b=mAxzKlsfVPj0xmo5wKI5El6SIoFMG9hkuMNWWnBacGo+eJYkRfx+es65cyKV8vLT0doTytChOvCkxAN+p+WB2EZu6MS5IzUj59kL8b4YRQhueFs0DKaSqAtRx8v43SJzP2l4O1z3EmwBUMLcI2CZhFq+Pxde1DRV045mCqVfTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765169829; c=relaxed/simple;
	bh=xuk1x3cM1pCdWbxqhMrjLzla1U2Mr1+istzyWxr1IYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+ohhxJcHEDP+P1I7WMeh2CeDTokDb2mnsJhTCvKr+KD2OC46E5cVsOHsEReyYbIfpLd+3wgT/k8C+gMiZanF77jaNfHEez85Hyne/UPaV9h4DEMkWjIwhFswtwbV3b812ThVHahXpyVU477Op+GCNHVJ3+lYKRnoMbO0cQ6Jps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+OtRe8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+OtRe8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C6C4CEF1;
	Mon,  8 Dec 2025 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765169828;
	bh=xuk1x3cM1pCdWbxqhMrjLzla1U2Mr1+istzyWxr1IYE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u+OtRe8B3EXskeWcLc7LRZhG7xojTI8PV+eJJbTiX2egQRMaSnLH12DipuhPIP1px
	 m41sLtKM3D4MIa64PW8kCRDFLU1pigIusBA3r9QX9uD4DJWFjAYWRhfEwEo1wC+FdW
	 8eZa0hle0WP+bnAN78JlIakxmx4FHWa1SWGgW0ha+MStlQG5zJDnaY2Bay2p7BCW9f
	 P7cXWp2njoIRNNo2Zv3T1JEON4n/frn0OEjSWLDLiyB/+sgnjYduGe+++uHfWmXekZ
	 hZYBT/Ay1URa7q90EIflXzL/jzJpGryiLjtnTxHpbueGEDGkOEgQHn9ow/1EoTr+m7
	 bUvWj1J3ox9Xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4DB96CE0E29; Sun,  7 Dec 2025 20:57:02 -0800 (PST)
Date: Sun, 7 Dec 2025 20:57:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: amd iommu: rcu: INFO: rcu_preempt detected expedited stalls on
 CPUs/tasks: { 0-.... } 8 jiffies s: 113 root: 0x1/.
Message-ID: <de21f62b-c246-4ff7-9825-600fe19af28a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251126143219.GBaScPc1b6RAC9ZfCv@fat_crate.local>
 <20251126152637.GDaSccLZVBEOs20n6T@fat_crate.local>
 <17147c98-9f0d-45d0-9593-3ede27ba6135@paulmck-laptop>
 <20251203124422.GBaTAwpmOzChS2MDhX@fat_crate.local>
 <cb2785d6-ee19-4277-9906-d287341c7698@paulmck-laptop>
 <20251204144505.GCaTGecavu-E56OR8V@fat_crate.local>
 <d90a3959-eacd-495e-99cd-836d07955912@paulmck-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90a3959-eacd-495e-99cd-836d07955912@paulmck-laptop>

On Thu, Dec 04, 2025 at 12:42:52PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 04, 2025 at 03:45:05PM +0100, Borislav Petkov wrote:
> > On Wed, Dec 03, 2025 at 09:16:37AM -0800, Paul E. McKenney wrote:
> > > Or to some value that works for you.  But if you are not looking to be
> > > an expedited RCU CPU stall-warning pioneer, yes, setting it to zero is
> > > a good approach.
> > > 
> > > If you would like to be a more sane pioneer, setting it to (say) 11000
> > > (or 11 seconds) could be appropriate.  But what fun is sanity?  ;-)
> > 
> > Oh, I have a lot of excitement even without RCU experiments. :-P
> 
> ;-) ;-) ;-)
> 
> > But if you need me to try things, lemme know.
> > 
> > For now I've simply reset the values as to what defconfig sets them to:
> > 
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> 
> Sounds good, and thank you!

But this turned out to be too simple to fail to address (famous last
words!).  Please see below.

							Thanx, Paul

------------------------------------------------------------------------

commit 9776d62e236bef99859e9067f540aa6f6683b432
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Dec 7 20:49:35 2025 -0800

    rcu: Make expedited RCU CPU stall warnings detect stall-end races
    
    If an expedited RCU CPU stall ends just at the stall-warning timeout,
    the current code will print an expedited stall-warning message, but one
    that doesn't identify any CPUs or tasks causing the stall.  This is most
    likely to happen for short-timeout stalls, for example, the 20-millisecond
    timeouts that are sometimes used for small embedded devices.  Needless to
    say, these semi-empty stall-warning messages can be rather confusing.
    
    One option would be to suppress the stall-warning message entirely in
    this case, but the near-miss information can be quite valuable.
    
    This commit therefore detects this race condition and emits a "INFO:
    Expedited stall ended before state dump start" message to clarify matters.
    
    Reported-by: Borislav Petkov <bp@alien8.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6058a734090c1..fd02cd12b7980 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -589,7 +589,12 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 	pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 		j - jiffies_start, rcu_state.expedited_sequence, data_race(rnp_root->expmask),
 		".T"[!!data_race(rnp_root->exp_tasks)]);
-	if (ndetected) {
+	if (!ndetected) {
+		// This is invoked from the grace-period worker, so
+		// a new grace period cannot have started.  And if this
+		// worker were stalled, we would not get here.  ;-)
+		pr_err("INFO: Expedited stall ended before state dump start\n");
+	} else {
 		pr_err("blocking rcu_node structures (internal RCU debug):");
 		rcu_for_each_node_breadth_first(rnp) {
 			if (rnp == rnp_root)
